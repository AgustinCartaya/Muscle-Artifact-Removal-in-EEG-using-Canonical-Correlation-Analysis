function [Wx,Wy,r,U,V] = CCA(X,Y)
    fast = 0;
    if fast == 1
        [Wx,Wy,r,U,V] = canoncorr(X',Y');
        Wx = Wx';
        Wy = Wy';
        r = r';
        U = U';
        V = V';
    else
        % 1) ----------- calculate the covariance matrices
        % Rxx
        Rxx = covariance_matrix(X,X);
        % Ryy
        Ryy = covariance_matrix(Y,Y);
        % Rxy
        Rxy = covariance_matrix(X,Y);
        % Ryx
        Ryx = covariance_matrix(Y,X);
    
    
        % 2) ----------- calculate the canonical coeficients using eigenvectors
        % X coeficients
        % Rx = inv(Rxx)*Rxy*inv(Ryy)*Ryx;
        % [Wx,eigenval_x] = eig(Rx);
        [Wx,eigenval_x] = eig((Rxx\Rxy)*(Ryy\Ryx));
        
        % Y coeficients
        % Ry = inv(Ryy)*Ryx*inv(Rxx)*Rxy;
        % [Wy,eigenval_y] = eig(Ry);
        [Wy,eigenval_y] = eig((Ryy\Ryx)*(Rxx\Rxy));

        % floating point errors approximations produce a small imaginary part that can be ignored.
%         Wx = real(Wx);
%         Wy = real(Wy);

        % sort eigen vector by eigein values ^2 in descending order
        [Wx,eigenval_x] = sort_eigen(Wx, eigenval_x);
        [Wy,eigenval_y] = sort_eigen(Wy, eigenval_y);
    
        % 3) ----------- find U and V in the multiple dimensions
        U = Wx' * X;
        V = Wy' * Y;
    
    
        % 4) ----------- find standarize coeficients (optional)
        % a) divide the eigen vectors by the respective standart deviation of U and V
        
        % a.1) calc the standart deviation of the U and V of all dimensions
        stdU=std(U,[],2);
        stdV=std(V,[],2);
        
        % a.2) finding the inverse of each element
        stdU = 1./stdU;
        stdV = 1./stdV;
        
        % a.3) creating diagonal matrix of standart deviation (std matrix)
        % on this way we can make a matrix mutltiplication
        stdU = diag(stdU);
        stdV = diag(stdV);
        
        % a.4) multiply the eigen vectors by std matrix
        zWx = Wx * stdU;
        zWy = Wy * stdV;
        
        % b) remove the mean of all the velues on X
        % b.1) calculate the mean of all Xi
        meanX = mean(X,2);
        meanY = mean(Y,2);
        
        % b.2) remove means
        Xmean = X - meanX;
        Ymean = Y - meanY;
        
        % c) calculate ztandarized coeficients
        zU = zWx' * Xmean;
        zV = zWy' * Ymean;
    
        % 5) ----------- Calculate loadings (optional)
        r = correlation_coeficitent_matrix([X;Y], [zU(1,:);zV(1,:)]);

        % returning normalized values
        
        U = zU; % original sources
        V = zV; % original sources
        Wx = zWx'; % unmixing matrix
        Wy = zWy'; % unmixing matrix



    end 

end
