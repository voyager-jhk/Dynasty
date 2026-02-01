import type { HistoricalEvent, StateVector } from "./types";

export class NarrativeGenerator {
  private apiKey: string;
  private baseURL: string;
  private model: string;
  private cache = new Map<string, string>();

  constructor(config: { apiKey: string; baseURL: string; model: string }) {
    this.apiKey = config.apiKey;
    this.baseURL = config.baseURL;
    this.model = config.model;
  }

  async generate(event: HistoricalEvent, state: StateVector): Promise<string> {
    const cacheKey = `${event.type}_${Math.floor(event.intensity * 10)}_${state.phase}`;

    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey)!;
    }

    const prompt = this.buildPrompt(event, state);

    try {
      const response = await fetch(`${this.baseURL}/v1/chat/completions`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${this.apiKey}`,
        },
        body: JSON.stringify({
          model: this.model,
          messages: [
            { role: "system", content: this.getSystemPrompt() },
            { role: "user", content: prompt },
          ],
          temperature: 0.7,
          max_tokens: 150,
        }),
      });

      const data = await response.json();
      const narrative = data.choices[0].message.content.trim();

      this.cache.set(cacheKey, narrative);
      return narrative;
    } catch (error) {
      console.error("Narrative generation failed:", error);
      return this.getFallback(event.type);
    }
  }

  private getSystemPrompt(): string {
    return `你是《安邦史稿》的太史公。将历史事件转化为简洁严肃的史书记载。

要求：
1. 文白相间的历史叙事语言
2. 50字以内
3. 只陈述事实，不加评价
4. 参考《史记》《资治通鉴》笔法

不要标点符号，不要分段。`;
  }

  private buildPrompt(event: HistoricalEvent, state: StateVector): string {
    return `将以下事件转化为史书记载：

年份: ${event.year}
事件: ${event.type}
强度: ${event.intensity.toFixed(2)}
人口: ${(state.population / 1e6).toFixed(1)}M
PSI: ${state.PSI.toFixed(2)}

生成简洁历史叙事（50字以内）：`;
  }

  private getFallback(type: string): string {
    const fallbacks: Record<string, string> = {
      famine: "是岁大饥，民流亡者数万",
      rebellion: "盗贼四起，郡县震动",
      crisis: "朝堂纷争，天下不靖",
      plague: "疫疠流行，死者枕藉",
    };
    return fallbacks[type] || "是岁多事";
  }
}
