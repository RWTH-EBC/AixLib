import requests
from datetime import datetime
from datetime import date
import argparse

class Slack_Notification(object):

    def __init__(self, github_token, slack_token, github_repo):
        self.slack_token = slack_token
        self.github_token = github_token
        self.github_repo = github_repo
        self.url = f'https://api.github.com/repos/{github_repo}/branches'

    def _get_data(self,  branch):  # date of last commit
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
        #commit = commit["committer"]
        author = commit["author"]
        return author

    def _get_branches(self):  # get a list of branches in repo
        try:
            url = f'{self.url}?per_page=100'
            payload={}
            headers = {
                'Authorization': 'Bearer ' + self.github_token,
                'Content-Type': 'application/json'
            }
            response = requests.request("GET", url, headers=headers, data=payload)
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

    def _get_user_list(self):
        url = "https://slack.com/api/users.list"
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.slack_token
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        slack_user_list = response.json()
        return slack_user_list

    def _get_slack_mail(self, slack_user_list):
        slack_mail_id = {}
        member_array = slack_user_list["members"]
        for member in member_array:
            profile = member["profile"]
            slack_email = profile.get("email")
            id = member.get("id")
            if slack_email is None:
                continue
            slack_mail_id[slack_email] = id
        return slack_mail_id

    def _get_slack_id(self, github_mail, slack_mail_id, name):
        for slack_email in slack_mail_id:
            if github_mail.find("@rwth-aachen.de") > -1:
                if github_mail.replace("@", "@eonerc.").lower() == slack_email.lower():
                    print(f'Slack Email: {slack_email}')
                    id = slack_mail_id[slack_email]
                    print(f'Slack id: {id}')
                    return id

        for slack_email in slack_mail_id:
            if github_mail.lower() == slack_email.lower():
                print(f'Slack Email: {slack_email}')
                id = slack_mail_id[slack_email]
                print(f'Slack id: {id}')
                return id
        for slack_email in slack_mail_id:
            if github_mail[:github_mail.rfind("@")].lower() == slack_email[:slack_email.rfind("@")].lower():
                print(f'Slack Email: {slack_email}')
                id = slack_mail_id[slack_email]
                print(f'Slack id: {id}')
                return id

        print(f'Cannot find Slack ID of user: {name} \nSend Slack message to channel fg-modelica')
        id = "CBZ9FJH27"
        print(f'Slack channel fg-modelica-id: {id}')
        return id


    def _delete_branch(self, branch):
        url = f'https://api.github.com/repos/{self.github_repo}/git/refs/heads/{branch}'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token
        }
        response = requests.request("DELETE", url, headers=headers, data=payload)
        print(response.text)

    def _get_pr_number(self, branch):
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

    def return_owner(self):
        owner = self.github_repo.split("/")
        return owner[0]

    def _open_pr(self, branch, owner):
        base_branch = "development"
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
        #print(response.text)
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
    slack_user_list = slack._get_user_list()
    slack_mail_id = slack._get_slack_mail(slack_user_list)
    time_list = []
    l_time = slack._local_time()
    branch_list = slack._get_branches()

    for branch in branch_list:
        if branch == "development" or branch == "master":
            continue
        author = slack._get_data(branch)
        name = author["name"]
        github_mail = author["email"]
        time = slack._get_time(author)
        previous_date = str(l_time - time)

        if previous_date.find("days") > -1:
            time_dif = int(previous_date[:previous_date.find("days")])
            if time_dif > 180:
                if branch.find("Correct_HTML") > -1:
                    slack._delete_branch(branch)
                    continue
                print(f'\n******************************')
                print(f'Name: {name}')
                print(f'Branch: {branch}')
                print(f'GitHub E-Mail: {github_mail}')
                channel_id = slack._get_slack_id(github_mail, slack_mail_id, name)
                owner = slack.return_owner()
                slack._open_pr(branch, owner)
                pr_number = slack._get_pr_number(branch)

                link_branch = f'https://github.com/{args.github_repo}/tree/{branch}'
                link_pr = f'https://github.com/{args.github_repo}/pull/{str(pr_number)}'
                message_text = f'The branch {branch} has been inactiv for more than {time_dif} days. ' \
                               f'A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch.' \
                               f'\nBranch URL: {link_branch}' \
                               f'\nPull Request URL: {link_pr}'
                print(message_text)
                slack._post_message(channel_id, message_text)
                slack._close_pr(pr_number)
                slack._delete_branch(branch)
                continue
            if time_dif > 90:
                if branch.find("Correct_HTML") > -1:
                    continue
                print(f'\n******************************')
                print(f'Name: {name}')
                print(f'Branch: {branch}')
                print(f'GitHub E-Mail: {github_mail}')
                channel_id = slack._get_slack_id(github_mail, slack_mail_id, name)
                link_branch = f'https://github.com/{args.github_repo}/tree/{branch}'

                message_text = f'The branch {branch} has been inactiv for more than {time_dif} days. The branch is automatically deleted after 180 days. If you want to keep the branch, add changes to the branch.' \
                               f'A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch. ' \
                               f'\nBranch URL: {link_branch}'
                print(message_text)
                slack._post_message(channel_id, message_text)
                continue
            else:
                continue

