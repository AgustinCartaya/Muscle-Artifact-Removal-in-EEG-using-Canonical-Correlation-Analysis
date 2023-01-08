function f = single_covariance(x1,x2)
    [sc,sr] = size(x1);
    s = sc;
    if sc < sr
        s = sr;
    end
    f = sum((x1-mean(x1)).*(x2-mean(x2)))/(s-1);
    %f = sum(x1.*x2)/s - sum(x1)/s * sum(x2)/s;
end