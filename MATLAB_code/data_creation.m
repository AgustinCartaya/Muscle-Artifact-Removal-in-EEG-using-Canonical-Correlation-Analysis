% --------------------- Data creation
function [EEG, S, A, EEG_clean] = data_creation(nb_sources, max_samples)
    
    t = zeros(1,max_samples);
    for i=1:max_samples
        t(1,i) = 2*pi*i/max_samples;
    end

    % creating EEG source
    S = zeros(nb_sources, size(t,2));
    for i=1:nb_sources - 1
        S(i,:) = sin(i*t);
    end
    
    % adding muscle artifact source
    S(nb_sources,:) = rand(1,max_samples)*2-1;
    % S(nb_sources,:) = awgn(sin(t),10);


%     --------- mixing matrix

%     A = [1 1 1 1 1 1
%         0 1 1 1 1 2
%         1 0 1 1 1 3
%         0 1 0 1 0 4
%         1 0 1 0 1 5
%         1 2 3 4 5 6];

    A = randi([-10 10],nb_sources,nb_sources);
    while (rank(A) < nb_sources)
        A = randi([0 10],nb_sources,nb_sources);
    end
    
    % mixing sources to obtains EEG signal
    EEG = A * S;
    EEG_clean = A * [S(1:end-1,:); zeros(1,size(t,2))];
end
