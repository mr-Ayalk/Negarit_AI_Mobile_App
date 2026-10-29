import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Negarit admin",
  description: "Operator tools for Negarit AI venues. Sign-in is not connected yet.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
