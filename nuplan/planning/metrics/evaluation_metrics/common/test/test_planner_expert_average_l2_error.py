from typing import Any, Dict

import pytest

from nuplan.common.utils.testing.nuplan_test import NUPLAN_TEST_PLUGIN, nuplan_test
from nuplan.planning.metrics.evaluation_metrics.common.planner_expert_average_l2_error import (
    PlannerExpertAverageL2ErrorStatistics,
)
from nuplan.planning.metrics.utils.testing_utils import metric_statistic_test


@nuplan_test(path='json/planner_expert_average_l2_error/planner_expert_average_l2_error.json')
def test_planner_miss_rate(scene: Dict[str, Any]) -> None:
    """
    Tests planner_expert_average_l2_error is expected value.
    :param scene: the json scene.
    """
    metric = PlannerExpertAverageL2ErrorStatistics(
        'planner_expert_average_l2_error',
        'Planning',
        comparison_horizon=4,
        comparison_frequency=1,
    )
    metric_statistic_test(scene=scene, metric=metric)


if __name__ == '__main__':
    raise SystemExit(pytest.main([__file__], plugins=[NUPLAN_TEST_PLUGIN]))
