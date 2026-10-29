import { Module } from '@nestjs/common';
import { AdminModule } from './admin/admin.module.js';
import { AdsModule } from './ads/ads.module.js';
import { AiModule } from './ai/ai.module.js';
import { AnalyticsModule } from './analytics/analytics.module.js';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { AuthModule } from './auth/auth.module.js';
import { BeaconsModule } from './beacons/beacons.module.js';
import { CommerceModule } from './commerce/commerce.module.js';
import { ContentModule } from './content/content.module.js';
import { HealthModule } from './health/health.module.js';
import { I18nModule } from './i18n/i18n.module.js';
import { NotificationsModule } from './notifications/notifications.module.js';
import { PaymentsModule } from './payments/payments.module.js';
import { RecommendationsModule } from './recommendations/recommendations.module.js';
import { VenuesModule } from './venues/venues.module.js';
import { WayfindingModule } from './wayfinding/wayfinding.module.js';
import { ZonesModule } from './zones/zones.module.js';

@Module({
  imports: [
    HealthModule,
    AuthModule,
    VenuesModule,
    ZonesModule,
    BeaconsModule,
    ContentModule,
    I18nModule,
    WayfindingModule,
    AiModule,
    RecommendationsModule,
    AdsModule,
    CommerceModule,
    PaymentsModule,
    NotificationsModule,
    AnalyticsModule,
    AdminModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
