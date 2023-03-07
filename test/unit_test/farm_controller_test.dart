import 'package:epoultry/controllers/farm_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'FarmsController',
    () {
      late FarmsController controller;
      setUp(
        () {
          controller = FarmsController();
        },
      );

      test('filterBatches', () {
        // Given
        var batchesList = [
          {'name': 'Rye'},
          {'name': 'Layers'},
          {'name': 'Nelly'},
        ];
        controller.batchesList.value = batchesList;

        // When
        controller.filterBatches('Rye');

        // Then
        expect(controller.foundBatches, [
          {'name': 'Rye'}
        ]);
      });

      test('applySubCounties', () {
        // Given
        var subCounties = ['subcounty 1', 'subcounty 2'];

        // When
        controller.applySubCounties(subCounties);

        // Then
        expect(controller.filteredSubCounties, subCounties);
      });

      test('applyWards', () {
        // Given
        var wards = ['ward 1', 'ward 2'];

        // When
        controller.applyWards(wards);

        // Then
        expect(controller.filteredWards, wards);
      });

      test('updateFarm', () {
        // Given
        var selectedFarm = {'name': 'Farm 1'};

        // When
        controller.updateFarm(selectedFarm);

        // Then
        expect(controller.farm, selectedFarm);
      });

      test('updateFarms', () {
        // Given
        var farms = [
          {'name': 'Farm 1'},
          {'name': 'Farm 2'},
          {'name': 'Farm 3'},
        ];

        // When
        controller.updateFarms(farms);

        // Then
        expect(controller.farms, farms);
      });

      test('updateBatches', () {
        // Given
        var batches = [
          {'name': 'Batch 1'},
          {'name': 'Batch 2'},
          {'name': 'Batch 3'},
        ];

        // When
        controller.updateBatches(batches);

        // Then
        expect(controller.batchesList, batches);
      });

      test('updateReports', () {
        // Given
        var reports = [
          {'name': 'Report 1'},
          {'name': 'Report 2'},
          {'name': 'Report 3'},
        ];

        // When
        controller.updateReports(reports);

        // Then
        expect(controller.reportsList, reports);
      });
    },
  );
}
