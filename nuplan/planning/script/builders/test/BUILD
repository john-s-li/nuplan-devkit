load("@rules_python//python:defs.bzl", "py_test")

package(default_visibility = ["//visibility:public"])

py_test(
    name = "test_log",
    size = "medium",
    srcs = ["test_log.py"],
    deps = [
        "//nuplan/planning/script/builders:logging_builder",
    ],
)

py_test(
    name = "test_builder_utils",
    size = "medium",
    srcs = ["test_builder_utils.py"],
    deps = [
        "//nuplan/planning/script/builders/utils:utils_config",
    ],
)

py_test(
    name = "test_scenario_builder",
    size = "medium",
    srcs = ["test_scenario_builder.py"],
    deps = [
        "//nuplan/planning/script/builders:scenario_builder",
        "//nuplan/planning/training/experiments:cache_metadata_entry",
        "//nuplan/planning/training/modeling:torch_module_wrapper",
        "//nuplan/planning/training/modeling:types",
        "//nuplan/planning/training/preprocessing/feature_builders:abstract_feature_builder",
        "//nuplan/planning/utils/multithreading:worker_pool",
    ],
)
