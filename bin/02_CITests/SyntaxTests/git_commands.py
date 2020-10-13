#from git import repo
import git 

class Git_Repository_Clone(object):
	"""work with Repository in Git"""
	def __init__(self, Repository):
		self.Repository = Repository

	def  _CloneRepository(self):
		git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
		#git diff --raw HEAD^1
		repo_dir = "IBPSA"
		repo = Repo.clone_from(git_url, repo_dir)
		print(repo)

	def _git_push_WhiteList(self):
		WhiteList_file = "bin"+os.sep+"03_WhiteLists"+os.sep+"WhiteList_CheckModel.txt"
		repo_dir = ""
		try:
			repo = Repo(repo_dir)
			commit_message = "Update new WhiteList [ci skip]"
			repo.git.add(WhiteList_file)
			repo.index.commit(commit_message)
			origin = repo.remote('origin')
			origin.push('master')
			repo.git.add(update=True)
			print("repo push succesfully")
		except Exception as e:
			print(str(e))
		
class collect_diff_files(object):
	def __init__(self)
		
		
		
if  __name__ == '__main__':
	hcommit = repo.heads.commit
	hcommit.diff()                  # diff tree against index
	hcommit.diff('HEAD~1') 