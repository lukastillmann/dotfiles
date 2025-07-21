/* First two elements in arguments array are node specific. The third index contains the first argument provided to the script */
const args = process.argv.slice(2);

const cmd = {
    thisBranch: "git rev-parse --abbrev-ref HEAD",
    getBranches: "git branch -r --merged | grep -v HEAD",
    findBranch: (string) => `git branch -a | grep -i ${string} | head -n 1`,
    getLastChanges: (branchName) => `git show --format="%ci" ${branchName} | head -n 1`,
    branchExists: (branchName) => `git rev-parse --verify ${branchName}`,
    tagExists: (tagName) => `git tag -l ${tagName}`,
    checkoutBranch: (branchName) => `git checkout ${branchName}`,
    archiveBranch: (branch, tag) =>
        `git checkout ${branch} && git pull && git push&& git tag ${tag} ${branch} && git push --tags`,
    deleteBranch: (branch) =>
        `git checkout develop && git branch -d ${branch} && git push origin --delete ${branch}`,
};

const main = async () => {
    /**
     * Executes a shell command and return it as a Promise.
     *
     * @param {String} cmd
     * @param {String} errorMsg
     * @returns {Promise<string>}
     */
    function execShellCommand(cmd, errorMsg) {
        const exec = require("child_process").exec;
        return new Promise((resolve, reject) => {
            exec(cmd, (error, stdout, stderr) => {
                if (error) {
                    reject(errorMsg || error);
                }
                resolve(stdout ? stdout : stderr);
            });
        });
    }

    try {
        const branchName = (await execShellCommand(cmd.findBranch(args[0]), "no branch found"))
            .replace("*", "")
            .trim();

        /* Check if branch exists. Throws an error if branch doesn't exist */
        const branchExists = await execShellCommand(
            cmd.branchExists(branchName),
            `Branch ${branchName} does not exist`,
        );

        await execShellCommand(cmd.checkoutBranch(branchName.replace("remotes/origin/", "")));
    } catch (err) {
        console.error("[ERROR] An error occured ", err);
    }
};

main();
