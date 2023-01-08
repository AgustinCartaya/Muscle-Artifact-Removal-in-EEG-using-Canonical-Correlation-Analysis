function f = correlation_coeficitent_matrix(X,Y)
    rows_x = size(X,1);
    rows_y = size(Y,1);
    f = zeros(rows_x,rows_y);

    for i = 1:rows_x
        for j = 1:rows_y
            h = corrcoef(X(i,:),Y(j,:));
            f(i,j) = h(1,2);
        end
    end
end

