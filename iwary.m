function y = iwary(N)
    y_t = zeros(N);
    for id = 0:1:N-1
        for ik = 0:1:N-1
            y_t(id+1, ik+1) = conj(w(id*ik, N)); % Take complex conjugate
        end
    end
    y = y_t;
end