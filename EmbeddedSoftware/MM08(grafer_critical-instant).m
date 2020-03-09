t=0:0.1:360;
% Laver bare et interval 0 til 160.

figure(1)
% DMA, exact criterion.
plot(t,t,t,ceil(t/40)*10);
% Med udgangspunkt i task 2: Summen af y for alle tasks med højere prioritet (1).
hold on
plot(t,t,t,ceil(t/40)*10+ceil(t/60)*20);
% Med udgangspunkt i task 3: Summen af y for alle tasks med højere prioritet (2 og 1).
hold off
% t,t er hvor meget tid der går per tid :)
% y-aksen er hvor meget tid vi skal bruge for at nå det hele.
% Her starter grafen over t,t, men den skal ende med at blive under.

figure(2)
% EDF, exact criterion.
plot(t,t,t,ceil((t-20)/40)*10+ceil((t-30)/60)*20+ceil((t-80)/80)*20);
% Summen af y for alle tasks.
% Hvad sker der lige her?