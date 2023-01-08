function plot_EEG(varargin)

    max_nb_signals = 8;
    % number of other set of signals to plot
    nVarargs = length(varargin);


    [nb_signals, nb_samples] = size(varargin{1});
    t = [1:1:nb_samples];
    figure
    for i = 1:nb_signals  
        if nb_signals > max_nb_signals && i-1 > 0 && mod(i-1,max_nb_signals) == 0
            figure
        end

        subplot(min(max_nb_signals, nb_signals),1,mod(i-1,max_nb_signals)+1)
      
        for k = 1:nVarargs-1
            ski = varargin{k}(i,:);
            plot(t', real(ski'), varargin{nVarargs}(1,k));
            hold on;
        end
        
        set(gca,'XColor', 'none','YColor','none');
    end
end