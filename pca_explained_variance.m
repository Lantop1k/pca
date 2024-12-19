   
   data = rand(1000,500); %% input data (1000,500)
   num_new_space=25;   % number of pca to create

   %% function to perform PCA
   
   %% step 1: compute the difference from the mean of the dataset
   X_diff = data - mean(data);  
   
   %% step 2: compute the covariance of the difference
   covmatrix = cov(X_diff);  % compute the variance
   
   %% step 3: Eigen vector decomposition for the covariance matrix 
   [eigvectors, eigmatrix]=eig(covmatrix);  % we get vectors and matrix here
   
   %% step 4: we extract the diagonal of the eigen values (extract the values) and sort it
   values = diag(eigmatrix); 
   [~, sortidx] = sort(values, 'descend'); % sort decending order (higher eigen values first)
    
   svectors = eigvectors(:, sortidx);   % sorted vectors , we sort the matrix based on the values
   svalues = values(sortidx);         % sorted values
   
   % extract the vectors, we extract top vectors here based on the number
   % of new plane to be tranformed, so top 25
   selected_vectors = svectors(:, 1:num_new_space); % new data, or transformed data is gotten after thi step
   
   
   %% step 5 : principal component data  , here this is our new data, new component
   X_pca = X_diff * selected_vectors;  
   
   %% step 6 compute explained variance, we compute variance ratio
   total_variance = sum(svalues);
   variance = sum(svalues(1:num_new_space)) / total_variance;
   
   
   %% our new data or transformed data after PCA is now (1000,25)
   %% our old data was 1000,500, so PCA reduced dimension based on the number of components selected
   %% our variance ratio is