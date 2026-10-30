import type { ReactNode } from "react";
import Link from "next/link";

const areas = [
  { href: "/", label: "Overview" },
  { href: "/venues", label: "Venues" },
  { href: "/content", label: "Content" },
  { href: "/beacons", label: "Beacons" },
  { href: "/offers", label: "Offers" },
  { href: "/analytics", label: "Analytics" },
] as const;

export function AdminShell({
  title,
  audience,
  notice = "No operator is signed in. Authentication is not connected, so these pages do not load venue data.",
  children,
}: {
  title: string;
  audience: string;
  notice?: string;
  children: ReactNode;
}) {
  return (
    <div className="mx-auto flex min-h-screen max-w-5xl flex-col gap-6 px-6 py-8">
      <header className="flex flex-col gap-4">
        <p className="text-sm font-semibold text-primary">Negarit AI</p>
        <h1 className="text-3xl font-semibold tracking-tight">{title}</h1>
        <p className="text-sm text-muted">Intended audience once sign-in exists: {audience}</p>
        <p className="max-w-2xl text-muted">{notice}</p>
        <nav className="flex flex-wrap gap-2" aria-label="Admin areas">
          {areas.map((area) => (
            <Link
              key={area.href}
              href={area.href}
              className="rounded-2xl bg-white px-4 py-2 text-sm font-medium text-ink shadow-sm"
            >
              {area.label}
            </Link>
          ))}
        </nav>
      </header>
      <section className="rounded-card bg-white p-6 shadow-sm">{children}</section>
    </div>
  );
}
