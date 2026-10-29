import { AdminShell } from "@/components/admin-shell";

export default function Home() {
  return (
    <AdminShell title="Overview" audience="Admin and merchant">
      <p>
        This is the operator shell for museums and merchants. Beacon mapping,
        content, offers, and analytics will appear here after sign-in exists.
      </p>
      <p className="mt-4 text-muted">Nothing on this page is live data.</p>
    </AdminShell>
  );
}
