raw_scan_1 = getDataFromFile("mapa2/log1_mapa2.txt");
raw_scan_2 = getDataFromFile("mapa2/log2_mapa2.txt");
raw_scan_3 = getDataFromFile("mapa2/log3_mapa2.txt");
raw_scan_4 = getDataFromFile("mapa2/log3_mapa2.txt");

calib_scan = calibrateScan(raw_scan_1, raw_scan_2, [70 0]);
calib_scan = calibrateScan(calib_scan, raw_scan_4, [0 -70]);
soft_scan = softFilter(calib_scan);
% soft_scan = softFilter(soft_scan);
polarplot(soft_scan);
% polarplot(calib_scan);