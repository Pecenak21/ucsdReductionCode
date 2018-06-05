clear
clc

pathToFile='C:\Users\Zactus\FeederReduction\8500-Node\Master.dss';
aname='8500';
o = actxserver('OpendssEngine.dss');
dssText = o.Text; dssText.Command = 'Clear';
dssText.Command = ['Compile "' pathToFile '"'];
dssCircuit = o.ActiveCircuit;
circuit.buslist.id=regexprep(dssCircuit.AllBUSNames,'-','_');
buslist=circuit.buslist.id;
circuit.buslist.coord=zeros(length(circuit.buslist.id),2);
delete(o);
clearvars o

count=0;

for jj=1:2
inds=1:100:length(buslist);
for ii=inds
	count=count+1;

	criticalBuses=buslist(round((length(buslist)-1)*rand(ii,1))+1);
	
	while length(unique(criticalBuses))<ii
		criticalBuses=[unique(criticalBuses); buslist(round((length(buslist)-1)*rand(ii-length(unique(criticalBuses)),1))+1)];
	end
	criticalBuses={'l2804247','l3197647','l3312692'};
	cd c:/users/zactus/FeederReduction/
	[circuit, circuit_orig, powerFlowFull, powerFlowReduced, ~,voltDiff] = reducingFeeders_Final(pathToFile,criticalBuses,[],1)
	Vmax(count)=max(voltDiff);
	Vmean(count)=mean(voltDiff);
	CB(count)=length(unique(strtok(powerFlowReduced.nodeName,'\.')));
	time_full(count)=powerFlowFull.timeSim;
	time_red(count)=powerFlowReduced.timeSim;
	red_time(count)=circuit.reductTime;
end
end
figure;plot(1-(CB./length(buslist)),Vmax,'*',1-(CB./length(buslist)),Vmean,'*')
save('OutputDSS/8500_max_mean.mat','Vmax','Vmean','CB','time_full','time_red','red_time')