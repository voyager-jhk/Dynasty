# Anbang Calibration Tools

Python tools for historical data calibration and model validation.

## Setup

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Usage

### Parameter Calibration

```bash
python scripts/calibrate_parameters.py --data data/ming_dynasty.csv
```

### Model Validation

```bash
python scripts/validate_model.py --historical data/ming_dynasty.csv --simulation results/simulation.json
```

### Visualization

```bash
python scripts/plot_results.py --input results/
```

## Jupyter Notebooks

```bash
jupyter lab
```

Open notebooks in `notebooks/` directory.

## Data Format

CSV files should have columns:

- `year`: Integer
- `population`: Float (in 万)
- `event`: String
- `intensity`: Float [0,1]

Example:

```csv
year,population,event,intensity
1368,6000,founding,0.0
1644,15000,collapse,1.0
```
