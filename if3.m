function y=if3(x)
tmp(:,:,1) = if2(x(:,:,1));
tmp(:,:,2) = if2(x(:,:,2));
tmp(:,:,3) = if2(x(:,:,3));
y=tmp;
end