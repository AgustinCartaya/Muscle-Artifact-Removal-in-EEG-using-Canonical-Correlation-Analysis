function f = covariance_matrix(X,Y)
    rows_x = size(X,1);
    rows_y = size(Y,1);
    f = zeros(rows_x,rows_y);

    for i = 1:rows_x
        for j = 1:rows_y
            f(i,j) = single_covariance(X(i,:),Y(j,:));
        end
    end
end

