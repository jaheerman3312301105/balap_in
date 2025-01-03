from django.core.management.base import BaseCommand
from django.utils.timezone import now
from datetime import timedelta
from balap_in_project.balap_in.models import Laporan 

class Command(BaseCommand):
    help = 'Update status cluster setelah 30 hari tidak ada yang melapor'

    print(now())

    def handle(self, *args, **kwargs):
        thirty_days_ago = now() - timedelta(days=30)

        clusters_to_update = Laporan.objects.filter(
            cluster__isnull=False,
            status__in=['selesai'],
        ).exclude(
            tgl_lapor__gte=thirty_days_ago
        ).values_list('cluster', flat=True).distinct()

        updated_count = Laporan.objects.filter(cluster__in=clusters_to_update).update(status='ditangani')

        self.stdout.write(self.style.SUCCESS(f'{updated_count} laporan telah diperbarui ke status "ditangani".'))
