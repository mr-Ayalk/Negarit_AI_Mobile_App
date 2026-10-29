import { AdminShell } from "@/components/admin-shell";

export default function ContentPage() {
  return (
    <AdminShell title="Content" audience="Admin">
      <p>
        Zone stories, audio, and translations are not loaded. English and
        Amharic will be reviewed before they are treated as final.
      </p>
    </AdminShell>
  );
}
