% CARGA DE DATOS DE FICHEROS LOG
raw_scan_1 = getDataFromFile("mapa1/log1_mapa1.txt");

% SUAVIZADO
% Se suavia el resultado anterior dos veces para reducir el ruido
soft_scan = softFilter(raw_scan_1);
soft_scan = softFilter(soft_scan);

% REPRESENTACIÓN VISUAL EN POLAR
figure(1)

subplot(1, 2, 1)
polarplot(raw_scan_1);

subplot(1, 2, 2)
polarplot(soft_scan);