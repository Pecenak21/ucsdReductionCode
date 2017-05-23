function [circuit] = addPV(circuit,pvfile,genbusflag)
% add PV sites to existing OpenDSS circuit
%
% inputs: 
%           circuit:    existing circuit created from dssconversion function
%           pvfile:     filename or file path for PV information of the circuit. Works for specific format right now. Please take a look at 520_PV.xlsx for reference.
%           genbusflag: (optional)flag to generate bus automatically based on pv location and use the generated bus           
%                       default: 1
%
% output: 
%           circuit:    with pv objects (dsspvsystem class) on it

if ~exist(pvfile,'file')
    pvfile = [pwd '/' pvfile];
end

if ~exist('genbusflag','var')
    genbusflag = 1;
end

%% Add PV to the system
% read pv data
pv = excel2obj(pvfile);
node = pv.nodes;
pv = pv.PV;

%% Auto find bus for each of the PV site based on its location
if genbusflag
    for i=1:length(pv)
        % read in the bus generated from the pdf map
        pv(i).readbus = node(pv(i).Node-1).NodeId;
        % locate bus based on PV location
        pv(i).bus = locateBus(circuit,pv(i).X_coordinate*1000,pv(i).Y_coordinate*1000);
    end
end
    
idx = ~strcmp({pv.readbus}', [pv.bus]');
if any(idx)
    a = find(idx);
    s = '';
    for i = 1:length(a)
        s = sprintf('%s %d',s,a(i));
    end
    warning(sprintf('There are %d mismatch(es) between bus ids read by human and ones generated by computer. \nMismatch index:%s',sum(idx),s));
end

%% add to circuit
fprintf('Converting pvsystem... '); t_ = tic;
p(length(pv)) = dsspvsystem;
for i = 1:length(pv)
    % Name without space
    p(i).Name = pv(i).Name;
    
    %let's say we trust human more than computer (by that I mean we will use the data read by
    %human if available rather than generated data)
    if isfield(p,'readbus') && ~genbusflag
        p(i).bus1 = pv(i).readbus;
    else
        p(i).bus1 = pv(i).bus;
    end
    p(i).kVA = regexprep(pv(i).Nominal_generation,'kw','','ignorecase');
end
toc(t_);

% output
circuit.pvsystem = p;

end