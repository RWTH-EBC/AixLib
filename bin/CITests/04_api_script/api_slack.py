import requests
from datetime import datetime
from datetime import date
import argparse

class Slack_Notification(object):

    def __init__(self, github_token, slack_token, github_repo):
        self.slack_token = slack_token
        self.github_token = github_token
        self.github_repo = github_repo
        self.url = "https://api.github.com/repos/" + github_repo + "/branches"

    def _get_date(self,  branch):  # date of last commit
        branch_url = self.url + "/" + branch
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", branch_url, headers=headers, data=payload)
        text = response.json()
        commit = text["commit"]
        commit = commit["commit"]
        commit = commit["committer"]
        return commit

    def _get_branches(self):  # get a list of branches in repo
        try:
            payload={}
            headers = {
                'Authorization': 'Bearer ' + self.github_token,
                'Content-Type': 'application/json'
            }
            response = requests.request("GET", self.url, headers=headers, data=payload)
            text = response.json()
            branch_list = []
            for dic in text:
                branch_list.append(dic["name"])
            return branch_list
        except requests.ConnectionError as e:
            print(e)

    def _local_time(self):
        l_time = date.today()
        return l_time

    def _get_time(self, commit):
        date = commit["date"]
        date = date[:date.find("T")]
        time = datetime.strptime(date, '%Y-%m-%d').date()
        return time

    def _get_name(self, commit):
        name = commit["name"]
        return name

    def _get_name_mail(self, commit):
        email = commit["email"]
        return email

    def _get_slack_id(self, github_mail):
        if github_mail.find("eonerc") == -1:
            github_mail = github_mail.replace("@", "@eonerc.")
        url = "https://slack.com/api/users.list"
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.slack_token
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        name_text = response.json()
        member_array = name_text["members"]
        for member in member_array:
            profile = member["profile"]
            slack_email = profile.get("email")
            if github_mail == slack_email:
                id = member.get("id")
                #print(f'Slack id: {id}')
                return id

    def _delete_branch(self, branch):
        url = f'https://api.github.com/repos/{self.github_repo}/git/refs/heads/{branch}'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token
        }
        response = requests.request("DELETE", url, headers=headers, data=payload)
        print(response.text)

    def _get_pr_number(self):
        branch = "slack"
        url = f'https://api.github.com/repos/{self.github_repo}/pulls'
        payload = {}
        headers = {
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        pull_request_json = response.json()
        for pull in pull_request_json:
            name = pull["head"].get("ref")
            if name == branch:
                return pull["number"]

    def _close_pr(self, pr_number):
        url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}'
        state = f'\"state\":\"closed\"'
        payload = "{\r\n" + state + "\r\n}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("PATCH", url, headers=headers, data=payload)
        print(response.text.encode('utf8'))

    def return_owner(self):
        owner = self.github_repo.split("/")
        return owner[0]

    def _open_pr(self, branch, owner):
        base_branch = "development"
        branch = "slack"
        url = f'https://api.github.com/repos/{self.github_repo}/pulls'
        title = f'\"title\": \"{branch} will be delete.\"'
        body = f'\"body\":\"The Branch {branch} is more than 180 days inactiv. The Branch and the Pull request will delte.\"'
        head = f'\"head\":\"{owner}:{branch}\"'
        base = f'\"base\": \"{base_branch}\"'
        message = f'\n	{title},\n	{body},\n	{head},\n	{base}\n'
        payload = "{" + message + "}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("POST", url, headers=headers, data=payload)
        print(response.text)
        return response

    def _post_message(self, channel_id, message_text):
        import logging
        from slack_sdk import WebClient  # Import WebClient from Python SDK (github.com/slackapi/python-slack-sdk)
        from slack_sdk.errors import SlackApiError
        #client = WebClient(token=os.environ.get("SLACK_BOT_TOKEN"))
        client = WebClient(token=self.slack_token)  # WebClient instantiates a client that can call API methods
        # When using Bolt, you can use either `app.client` or the `client` passed to listeners.
        logger = logging.getLogger(__name__)

        try:
            result = client.chat_postMessage(  # Call the chat.postMessage method using the WebClient
                channel=channel_id,
                text=message_text
            )
            logger.info(result)
        except SlackApiError as e:
            logger.error(f"Error posting message: {e}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Set Github Environment Variables")  # Configure the argument parser
    check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
    check_test_group.add_argument('-GT', "--github-token", default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
    check_test_group.add_argument('-ST', "--slack-token", default="${secrets.SLACK_BOT_TOKEN}", help="Your Set GITHUB Token")
    check_test_group.add_argument("-GR", "--github-repo", default="SvenHinrichs/GitLabCI",
                                  help="Environment Variable owner/RepositoryName")
    args = parser.parse_args()  # Parse the arguments
    from api_slack import Slack_Notification
    slack = Slack_Notification(github_token=args.github_token, slack_token=args.slack_token, github_repo=args.github_repo)

    time_list = []
    l_time = slack._local_time()
    branch_list = slack._get_branches()
    for branch in branch_list:
        commit = slack._get_date(branch)
        name = slack._get_name(commit)
        email = slack._get_name_mail(commit)
        if branch == "development" or branch == "master":
            continue
        print("******************************")
        print(f'Name: {name}')
        print(f'Email: {email}')
        print(f'Branch: {branch}')
        time = slack._get_time(commit)
        previous_date = str(l_time - time)
        if previous_date.find("days") > -1:
            time_dif = int(previous_date[:previous_date.find("days")])
            if time_dif > 180:
                message_text = f'The branch {branch} has been inactiv for more than {time_dif} days. A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch.'
                print(message_text)
                channel_id = slack._get_slack_id(email)
                slack._post_message(channel_id, message_text)
                owner = slack.return_owner()
                slack._open_pr(branch, owner)
                pr_number = slack._get_pr_number()
                slack._close_pr(pr_number)
                slack._delete_branch(branch)
                exit(0)
            if time_dif > 90:
                message_text = f'The branch {branch} has been inactiv for more than {time_dif} days. The branch is automatically deleted after 180 days. If you want to keep the branch, add changes to the branch. '
                print(message_text)
                channel_id = slack._get_slack_id(email)
                slack._post_message(channel_id, message_text)
                exit(0)
            else:
                print(f'Branch {branch} is since {time_dif} days inactive')
                exit(0)


