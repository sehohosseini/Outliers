clc
clear
close all
format compact
format short
%% Genrating data for this example
% You can import your data (name it data)
data=50*randn(100,1);
ind1=round(100*rand(1,10));
data(ind1)=round(800*rand(1,10));
ind2=round(100*rand(1,10));
data(ind2)=round(-800*rand(1,10));
%% Calculating the required values
NEW_data=data;
x=1:numel(data);
Nx = size(data,1);
mx = mean(data);
sigma = std(data);
medianx = median(data);
y = sort(data);
Q_first = median(y(y<median(y)));
Q_second = median(y);
Q_third = median(y(y>median(y)));
IQR = Q_third-Q_first;
%% Determination of outliers
out= zeros(1,numel(data));
for j=1:numel(data)
    if data(j) > Q_third+1.5*IQR || data(j) < Q_first-1.5*IQR
    out(j) = 1;
    end
end
out=logical(mod(out,0));
%% Replacing outliers with random values in the range
outliers_index=find(out==1);
for i=1:numel(outliers_index)
    if NEW_data(outliers_index(i))>(Q_third+1.5*IQR)
    NEW_data(outliers_index(i))=Q_second+rand*IQR;
    else
    NEW_data(outliers_index(i))=Q_second-rand*IQR;
    end
end
%% Plotting values
plot(x,data,x(out),data(out),'x',x,...
    (Q_first-1.5*IQR)*ones(1,numel(data)),x,...
    (Q_third+1.5*IQR)*ones(1,numel(data)),...
    x,Q_second*ones(1,numel(data)))
hold on
plot(x,NEW_data,'o')
legend('Original Data','Outlier','Lower Threshold','Upper Threshold','Median Value','New Data')
