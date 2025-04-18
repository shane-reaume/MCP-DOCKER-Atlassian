from typing import Any

class Jira:
    def worklog(self, issue_key: str) -> dict[str, Any]: ...
    def createmeta_issue_types(
        self,
        project_keys: str | None = None,
        issuetype_names: str | None = None,
        expand: str | None = None,
    ) -> dict[str, Any]: ...
    def issue_transitions(self, issue_key: str) -> dict[str, Any]: ...
    def comments(self, issue_key: str, limit: int | None = None) -> dict[str, Any]: ...
    def update_issue(self, issue_key: str, **fields: Any) -> None: ...
    def get_issue(self, issue_key: str) -> dict[str, Any]: ...
    def set_issue_status_by_transition_id(
        self, issue_key: str, transition_id: str | int
    ) -> None: ...
    def delete_issue(self, issue_key: str) -> None: ...
    def get_all_fields(self) -> list[dict[str, Any]]: ...
