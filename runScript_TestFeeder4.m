clear
clc

pathToFile='C:\Users\Zactus\FeederReduction\TestFeeder4.dss';
aname='Test$';
o = actxserver('OpendssEngine.dss');
dssText = o.Text; dssText.Command = 'Clear';
dssText.Command = ['Compile "' pathToFile '"'];
dssCircuit = o.ActiveCircuit;
circuit.buslist.id=regexprep(dssCircuit.AllBUSNames,'-','_');
buslist=circuit.buslist.id;
circuit.buslist.coord=zeros(length(circuit.buslist.id),2);
delete(o);
clearvars o
delete('c:\users\zactus\feederReduction\circuits\TestFeeder4_circuit.mat')
rmdir('c:\users\zactus\feederReduction\TestFeeder4\','s')

count=0;

for jj=1:2
inds=1:10:length(buslist);
for ii=inds
	count=count+1;

	criticalBuses=buslist(round((length(buslist)-1)*rand(ii,1))+1);
	
	while length(unique(criticalBuses))<ii
		criticalBuses=[unique(criticalBuses); buslist(round((length(buslist)-1)*rand(ii-length(unique(criticalBuses)),1))+1)];
	end
	
	
	cd c:/users/zactus/FeederReduction/
	[circuit, circuit_orig, powerFlowFull, powerFlowReduced, ~,voltDiff] = reducingFeeders_Final_SI(pathToFile,criticalBuses,[],1)
	Vmax(count)=max(voltDiff);
	Vmean(count)=mean(voltDiff);
	time(count)=circuit.reductTime;
	CB(count)=length(unique(strtok(powerFlowReduced.nodeName,'\.')));
	time_full(count)=powerFlowFull.timeSim;
	time_red(count)=powerFlowReduced.timeSim;
	
end
end
figure;plot(1-(CB./length(buslist)),Vmax,'*',1-(CB./length(buslist)),Vmean,'*')
hold on;plot(1-(CB_old./length(buslist)),Vmax_old,'*',1-(CB_old./length(buslist)),Vmean_old,'*')
figure;plot(1-(CB./length(buslist)),time,'*',1-(CB_old./length(buslist)),time_old,'*')

% save('OutputDSS/AlpineNew_max_mean.mat','Vmax','Vmean','CB','time_full','time_red','time','Vmax_old','Vmean_old','time_old','CB_old','time_red_old')