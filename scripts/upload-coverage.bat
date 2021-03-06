REM script called by Azure to combine and upload coverage information to codecov
if "%PYTEST_COVERAGE%" == "1" (
    echo Prepare to upload coverage information
    if defined CODECOV_TOKEN (
        echo CODECOV_TOKEN defined
    ) else (
        echo CODECOV_TOKEN NOT defined
    )
    python -m pip install codecov
    coverage combine
    coverage xml --ignore-errors
    coverage report -m --ignore-errors
    scripts\retry codecov --required -X gcov pycov search -f coverage.xml --flags windows
) else (
    echo Skipping coverage upload, PYTEST_COVERAGE=%PYTEST_COVERAGE%
)
