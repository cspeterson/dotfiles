""" End-to-end tests """

import pytest  # type:ignore
import {{cookiecutter.project_name}}.__main__ as program  # type:ignore


@pytest.mark.parametrize(
    "test_input,expected",
    [
        (
            # OK
            [
            ],
            {
                "returncode": 0,
                "output": "",
            },
        ),
    ],
    ids=[
        "Description of the test which is represented by the first set of values",
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
