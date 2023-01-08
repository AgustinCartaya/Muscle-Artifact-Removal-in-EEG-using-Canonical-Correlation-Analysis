% ---------------------------- OBTAINING DATA ------------------ ----------
% a) -------------- EEG creation (see data_creation.m)
% i) creation of sources
% in this example we have a group of sources S_original that are sinusoidal signals
% and a random token added to the last row of S_original.
% These sources represent the sources of the signals obtained by the EEG.
% sinusoidal signals represent the signals emitted by neurons
% and the random signal represents the signal emitted by the muscles.
% since by definition brain signals have a higher
% autocorrelation (they tend to be more periodic)
% compared to muscle signals

% ii) mixing of the sources to obtain the EEG signal
% the sources are mixed using the A_original matrix to do so
% get the EEG signals.
% This is done thanks to the Blind Source Separation BSS reasoning
%EEG = A_original * S_original

% b) -------------- dataset reading (see read_dataset.m)
% an EEG signal dataset was found in:
% https://physionet.org/content/chbmit/1.0.0/
% this datase contains 3600 recordings, each containing 22 signals
% each of 256 samples.
% the first recording of the dataset is read and some data sources are obtained
% is in the EEG variable

% --------------------------- METHOD --------------------- --------
% 1) -------------- Autoccorrelation
% the variables X = EEG and Y = X(t-1) are obtained

% 1) -------------- CCA (see CCA.m)
% Applies to the Canonical Correlation Analysis method for
% find the "sources" S_CCA (= to the canonical variants of X) and the
% unmixing matrix W (equal to the eigenvectors of X) from
%X&Y

% 2) -------------- BSS-CCA (obtaining EEG signal without muscle artifacts)
% once S_CCA and W have been obtained, the inverse matrix of W can be calculated
% call A which is the mix matrix. This matrix is going to be modified by placing zeros in all the
% entries corresponding to the sources of the muscles and thus obtain
%A_corrected. then EEG_corrected is obtained (EEG signals without the
% artifacts caused by muscles)
%EEG_corrected = A_corrected * S_CCA

% ---------------------------- PLOTTING (see plot_EEG.m) -------------- --------------
% A plot is made of the different original EEG signals (EEG),
% corrected EEG signals (EEG_corrected)

% ---------------------------- COMPARING RESULTS ------------------- ---------
% a comparison of the results obtained by the CCA function was made
% created and the original CCA function from matlab (canoncorr) a third
% result with the data of the variable Y was also compared.
% all 3 results are displayed on a graph in conjunction with the EEG signal
% original





% -------------------------- OBTAINING DATA --------------------------
nb_EEG_signals = 8;
% ------------- Creating EEG data -------------
% nb_samples = 256;
% [EEG, S_original, A_original, EEG_clean] = data_creation(nb_EEG_signals,nb_samples);

% ------------- Reading EEG data -------------
[EEG, EEG_names] = read_dataset(nb_EEG_signals);

% -------------------------- BEGINING OF THE METHOD --------------------------
% ------------- Autoccorrelation -------------

X = [zeros(size(EEG, 1),1), EEG(:,2:end)];
Y = EEG;

X = X - mean(X,2);
Y = Y - mean(X,2);

% ---------------------------- CCA ----------------------------------
[Wx,Wy,r,U,V] = CCA(X,Y);
% ---------------------------- BSS-CCA ----------------------------------
dimension_correction = 1;
% U = V =  sources
% Wx = Wy = unmixing matrices
% finding EEG_corrected
A = inv(Wx); 
if dimension_correction > 0
    U(end - dimension_correction:end, :) = 0;
end

EEG_corrected = A * U;
% -------------------------- END OF THE METHOD --------------------------


%  -------------------------- PLOT RESULTS --------------------------
% ---------------- mixed signals
% green: results
% red: original image
plot_EEG(EEG_corrected, EEG, ["-g", "-r"]);



