import { Suspense } from "react";
import { connection } from "next/server";
import { AdminShell } from "@/components/admin-shell";
import { loadAdwaVenue, type VenueRecord } from "@/lib/venue";

export default function VenuesPage() {
  return (
    <AdminShell
      title="Venues"
      audience="Admin"
      notice="No operator is signed in. Authentication is not connected. The list below is the public venue response."
    >
      <Suspense fallback={<p>Loading the venue from the API.</p>}>
        <VenueList />
      </Suspense>
    </AdminShell>
  );
}

async function VenueList() {
  await connection();
  const loaded = await loadAdwaVenue();
  if (!loaded.ok) {
    return (
      <p>
        {loaded.reason === "unreadable"
          ? "The venue response could not be read."
          : "The venue service was not reached. Start the API on port 3000."}
      </p>
    );
  }
  return <VenueDetails venue={loaded.venue} />;
}

function VenueDetails({ venue }: { venue: VenueRecord }) {
  return (
    <div className="flex flex-col gap-6">
      <div>
        <h2 className="text-xl font-semibold">{venue.nameEn}</h2>
        <p className="text-muted">{venue.nameAm}</p>
        <p className="mt-3 text-sm text-muted">
          {venue.slug} · {venue.status} · {venue.timezone}
        </p>
        <p className="mt-2 text-sm text-muted">
          Source: {venue.source}. Verified: {venue.verified ? "yes" : "no"}.
        </p>
        <p className="mt-2">{venue.note}</p>
      </div>
      <ul className="flex flex-col gap-4">
        {venue.zones.map((zone) => (
          <li key={zone.slug} className="border-t border-sky-bottom pt-4">
            <p className="font-medium">
              {zone.nameEn}{" "}
              <span className="font-normal text-muted">{zone.nameAm}</span>
            </p>
            <p className="text-sm text-muted">
              {zone.slug} · {zone.type}
            </p>
            {zone.stories.length === 0 ? (
              <p className="mt-1">No story is stored.</p>
            ) : (
              zone.stories.map((story) => (
                <p key={story.language} className="mt-1">
                  {story.language}: {story.body} ({story.provenance})
                </p>
              ))
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}
