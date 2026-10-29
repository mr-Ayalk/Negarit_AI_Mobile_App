import { AdminShell } from "@/components/admin-shell";

export default function BeaconsPage() {
  return (
    <AdminShell title="Beacons" audience="Admin">
      <p>Beacon-to-zone mapping is not loaded. No beacons are registered.</p>
    </AdminShell>
  );
}
