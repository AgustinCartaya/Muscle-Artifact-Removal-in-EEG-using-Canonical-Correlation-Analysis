function [s_vectors, s_values] = sort_eigen(vectors,values)
    s_vectors = zeros(size(vectors));
    s_values = diag(values).^2;
    [s_values,changes] = sort(s_values, "descend");
     for i = 1:size(changes,1)
         s_vectors(:,i) = vectors(:,changes(i));
     end
end