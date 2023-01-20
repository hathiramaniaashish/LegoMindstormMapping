filename = 'log-caja1_59x39.txt';
delimiterIn = ':';

data = importdata(filename,delimiterIn);

rho = data(:,2) + 8;
theta = data(:,3) * pi/180;

saveas(polarscatter(theta, rho), "puntosPolaresRaw.png");
saveas(polarplot(theta, rho), "mapeadoRaw.png");

dists = [];

for i = 1:length(rho)-1
    x1 = i;
    x2 = i+1;
    dist = sqrt(rho(x1)^2 + rho(x2)^2 - 2*rho(x1)*rho(x2)*cos(theta(x2)-theta(x1)));
    dists = [dists, dist];
end

dists = sort(dists);
dists = dists(1:64);
umb = mean(dists);
auxRho = [rho(x2)];
auxTheta = [theta(x2)];

for i = 1:length(rho)-1
    x1 = i;
    x2 = i+1;
    dist = sqrt(rho(x1)^2 + rho(x2)^2 - 2*rho(x1)*rho(x2)*cos(theta(x2)-theta(x1)));
    if dist <= umb
        auxRho = [auxRho, rho(x2)];
        auxTheta = [auxTheta, theta(x2)];
    end
end

saveas(polarscatter(auxTheta, auxRho), "puntosPolaresDepurado.png");
saveas(polarplot(auxTheta, auxRho), "mapeadoDepurado.png");