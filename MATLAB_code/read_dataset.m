function [EEG, EEG_names] = read_dataset(max_nb_signals)
    %  ---------------- Source ----------------
    % https://physionet.org/content/chbmit/1.0.0/
    
    % ---------------- read signals
    data_set = edfread('chb01_01.edf');
    
    % ---------------- read info signals
    info  = edfinfo('chb01_01.edf');
    EEG_names = info.SignalLabels;
    % info.DataRecordDuration
    
    % ---------------- number of saples of each signal divided by the duration
    fs = info.NumSamples/seconds(info.DataRecordDuration);
    
    % ---------------- creating X and Y signal matrix
    
    EEG = zeros(max_nb_signals,info.NumSamples(1));    
    for i = 1:max_nb_signals
        v = data_set.(i){1};
        EEG(i,:) = v';
    end
end