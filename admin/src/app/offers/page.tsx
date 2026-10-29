import { AdminShell } from "@/components/admin-shell";

export default function OffersPage() {
  return (
    <AdminShell title="Offers" audience="Admin and merchant">
      <p>
        Sponsored cards are not loaded. Payments stay off until a provider is
        configured. Reserve and pay-at-shop will remain available.
      </p>
    </AdminShell>
  );
}
