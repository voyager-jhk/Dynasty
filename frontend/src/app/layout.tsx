import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Project Anbang - Historical Dynamics Engine",
  description: "Academic historical simulation based on Cliodynamics",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
