function [varargout] = actograph(varargin)
%% actograph | a paltry actogram plotter for circadian rhythm data
% 
%% actograph readme
%{ 
%   %% actograph evoked with zero inputs generates & plots sample data
%
%           >> actograph();
%     
%       you can save the simulated dataset to your workspace by:
%     
%           >> simData = actograph();
% 
%   %% actograph evoked with an arg plots *your* circadian rhythem data
%
%           >> actograph(dataMx);
% 
% Where dataMx is a data matrix structured such that each row
% represents your binned activity data **as you want it plotted**.
% Basically, WYSIWYG. Each value from the dataMx will be plotted
% as a bar in the actogram. Each row in the dataMx will be a new row
% in the actogram. So if, for example, you want 48 hours worth of data 
% plotted on the same row in the actogram, and the next 48 hours on the
% next row (and so on...) just put that 48 hours worth of data in the
% same row of the dataset you send to actograph. Try it out...
%
%
%       >> actograph()
%
%       >> actograph(repmat([1:24 1:24],[20 1]));
%
%       >> days = 20; binsPerDay = 96
%       >> actograph(rand(days, binsPerDay));
%
%}


%% --| DEAL ARGS (TAKES 0 OR 1 NARGIN)

    if nargin < 1
        % clc; close all; clear all; 
        if (~isdeployed); cd(fileparts(which(mfilename))); end;

        % Generate circadian rhythem dataset structured such that
        circfunc = repmat([3.1:.03:4 4:-.03:3.1 rand(1,34)],[1 2]);
        crcdat = repmat(circfunc,[20 1]);
        crcdat=(1+rand(size(crcdat))).*crcdat;
        crcdat(crcdat<1)=0;
        
        daysProw = 2; Nrows = size(crcdat,1);
        binsPhr = size(crcdat,2)/daysProw/24;
        eShHr = .5; % shift entrainment schedule by 'eShHr' hours per day
        eSh = round(eShHr * binsPhr * daysProw);
        circdata=crcdat; uncircdat = crcdat;
        for nn = 10:Nrows
            crcdat = circshift(crcdat,[0 eSh]);
            circdata(nn,:) = crcdat(nn,:);
        end


    elseif nargin == 1
        %[circdata, days] = deal(varargin{:});
        circdata = varargin{:};

    else
        warning('ERROR, TOO MANY INPUT ARGS')
    end




%% --| PLOT COLORMAP AND BAR GRAPH WITH SMOOTHED SPLINE OVERLAY

f1 = figure(1);
    set(f1,'OuterPosition',[100 100 1200 900],'Color',[1 1 1]);
    hax1 = axes('Position',[.05 .55 .4 .4],'Color','none');
    hax2 = axes('Position',[.55 .55 .4 .4],'Color','none');
    colormap(hax1,'hot'); colormap(hax2,'bone');
            
    axes(hax1); axis off;
imagesc(circdata); 


    smeth = {'moving','lowess','loess','sgolay','rlowess','rloess'};
    degSm = .1; typSm = 5; muCd = mean(circdata);
    smUnc = smooth(muCd,degSm,smeth{typSm});

    axes(hax2); axis off;
bar(circdata'); 
    hold on; 
ph = plot(smUnc);
    set(ph,'Color',[.8 .1 .1],'LineWidth',4,'Marker','none');


%% --| PLOT ACTOGRAM ACTOGRAPH

numreps = size(circdata,1);
axPos = fliplr(linspace(.04, .50, numreps));
rowh = axPos(1) - axPos(2) - .005;
Ymax = max(max(circdata));

for nn = 1:numreps

    axes('Position',[.05 axPos(nn) .90 rowh],'Color','none',...
    'XTick',[],'YTick',[]); axis off; hold on;

    bar(circdata(nn,:))
        set(gca,'YLim',[0 Ymax]);

end


%%
varargout = {circdata};
end