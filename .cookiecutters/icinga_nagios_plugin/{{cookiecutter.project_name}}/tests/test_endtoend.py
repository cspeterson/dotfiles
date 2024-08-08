""" End-to-end tests """

import pytest  # type:ignore
import {{cookiecutter.project_name}}.__main__ as program  # type:ignore


@pytest.mark.parametrize(
    "test_input,expected",
    [
        (
            # OK
            [
                "--warning",
                ":1",
            ],
            {
                "returncode": 0,
                "output": "OK",
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
                "output": "WARNING",
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
                "output": "CRITICAL",
            },
        ),
    ],
    ids=[
        "Description of the test which is represented by the first set of values",
        "Description of the test which is represented by the second set of values",
        "Description of the test which is represented by the third set of values",
    ],
)
# pylint: disable=unused-argument
# pylint: disable=redefined-outer-name
def test_end_to_end(capsys, test_input, expected):
    """Test"""
    with pytest.raises(SystemExit) as excinfo:
        program.main(argv=test_input)
    assert excinfo.value.code == expected["returncode"]
    assert expected["output"] in capsys.readouterr()[0].rstrip("\n")


# pylint: enable=unused-argument
# pylint: enable=redefined-outer-name
