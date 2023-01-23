% CARGA DE DATOS DE FICHEROS LOG
raw_scan_1 = getDataFromFile("mapa2/log1_mapa2.txt");
raw_scan_2 = getDataFromFile("mapa2/log2_mapa2.txt");
raw_scan_3 = getDataFromFile("mapa2/log3_mapa2.txt");
raw_scan_4 = getDataFromFile("mapa2/log3_mapa2.txt");

% CALIBRACIÓN
% Se calibra el primer log en base al segundo log y su posición real
calib_scan = calibrateScan(raw_scan_1, raw_scan_2, [70 0]);
% Se calibra el resultado anterior en base al tercer log y su posición real
calib_scan = calibrateScan(calib_scan, raw_scan_4, [0 -70]);

% SUAVIZADO
% Se suavia el resultado anterior dos veces para reducir el ruido
soft_scan = softFilter(calib_scan);
soft_scan = softFilter(soft_scan);

% REPRESENTACIÓN VISUAL EN POLAR
figure(1)

subplot(1, 2, 1)
polarplot(raw_scan_1);

subplot(1, 2, 2)
polarplot(soft_scan);