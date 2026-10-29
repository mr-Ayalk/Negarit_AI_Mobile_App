import { AdminShell } from "@/components/admin-shell";

export default function AnalyticsPage() {
  return (
    <AdminShell title="Analytics" audience="Admin and merchant">
      <p>No visits have been recorded. Charts will stay empty until events exist.</p>
    </AdminShell>
  );
}
