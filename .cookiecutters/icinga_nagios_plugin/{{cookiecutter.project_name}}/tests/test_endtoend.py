""" End-to-end tests """

import subprocess

import pytest  # type:ignore


@pytest.mark.parametrize(
    "test_input,expected",
    [
        (
            # OK
            [],
            {
                "returncode": 0,
                "output_contains": "OK",
            },
        ),
        (
            # WARN
            [
                "--warning",
                "1:",
            ],
            {
                "returncode": 1,
                "output_contains": "WARNING",
            },
        ),
        (
            # CRIT
            [
                "--critical",
                "1:",
            ],
            {
                "returncode": 2,
                "output_contains": "CRITICAL",
            },
        ),
    ],
)
# pylint: disable=unused-argument
# pylint: disable=redefined-outer-name
def test_end_to_end(test_input, expected):
    """Test"""
    command = ["python3", "-m", "{{cookiecutter.project_name}}"] + [str(x) for x in test_input]
    res = subprocess.run(command, capture_output=True, check=False, text=True)
    assert res.returncode == expected["returncode"]
    assert expected["output_contains"] in res.stdout


# pylint: enable=unused-argument
# pylint: enable=redefined-outer-name
