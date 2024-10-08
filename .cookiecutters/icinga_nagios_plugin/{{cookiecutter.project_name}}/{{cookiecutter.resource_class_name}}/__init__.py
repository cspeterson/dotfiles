"""
Model the resource being monitored
"""

import logging

import nagiosplugin

# pylint: disable=too-few-public-methods
class {{cookiecutter.resource_class_name}}(nagiosplugin.Resource):
    """
    A model of the thing being monitored
    """

    def __init__(
        self,
    ) -> None:
        pass

    def probe(self) -> Generator[nagiosplugin.Metric, None, None]:
        """
        Run the check itself
        """
        logging.info("Running check...")
        yield nagiosplugin.Metric(
            "metric_name",
            0,
            context="context",
        )


# pylint: enable=too-few-public-methods
