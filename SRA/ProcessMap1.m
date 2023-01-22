raw_scan_1 = getDataFromFile("mapa1/log1_mapa1.txt");
raw_scan_2 = getDataFromFile("mapa1/log2_mapa1.txt");
raw_scan_3 = getDataFromFile("mapa1/log3_mapa1.txt");

calib_scan = calibrateScan(raw_scan_1, raw_scan_2, [30 30]);
calib_scan = calibrateScan(calib_scan, raw_scan_3, [-30 -30]);
soft_scan = softFilter(calib_scan);
soft_scan = softFilter(soft_scan);
soft_scan = softFilter(soft_scan);

figure(1)

subplot(1, 2, 1) % 2 rows, 1 column, first position
polarplot(raw_scan_1);

subplot(1, 2, 2)
polarplot(soft_scan);