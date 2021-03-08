svm_rec <-
  recipe(disease ~ ., train_data) %>%
  step_dummy(all_nominal(),-all_outcomes()) %>%
  step_normalize(all_numeric()) %>%
  prep()

svm_spec <- svm_poly(cost = tune(),
                     degree = tune()) %>%
  set_engine("kernlab") %>%
  set_mode("classification")

svm_workflow <- workflow() %>%
  add_recipe(svm_rec) %>%
  add_model(svm_spec)

svm_grid <- grid_regular(cost(),
                         degree(),
                         levels = 2)

save_preds <- control_grid(save_pred = TRUE)

doParallel::registerDoParallel()

set.seed(1)

svm_rs <- tune_grid(svm_workflow,
                    resamples = train_cv,
                    grid = svm_grid,
                    control = save_preds)

doParallel::stopImplicitCluster()

final_svm <-
  svm_workflow %>%
  finalize_workflow(select_best(svm_rs, "accuracy"))

fit_svm <-
  last_fit(final_svm, data_split)

fit_svm %>%
  collect_metrics()