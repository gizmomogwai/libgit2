module git2.pack;

import git2.common;
import git2.oid;
import git2.types;

extern (C):

enum git_packbuilder_stage_t {
	GIT_PACKBUILDER_ADDING_OBJECTS = 0,
	GIT_PACKBUILDER_DELTAFICATION = 1,
}

int git_packbuilder_new(git_packbuilder **out_, git_repository *repo);
uint git_packbuilder_set_threads(git_packbuilder *pb, uint n);
int git_packbuilder_insert(git_packbuilder *pb, const(git_oid)* id, const(char)* name);
int git_packbuilder_insert_tree(git_packbuilder *pb, const(git_oid)* id);
int git_packbuilder_insert_commit(git_packbuilder *pb, const(git_oid)* id);
int git_packbuilder_write(
	git_packbuilder *pb,
	const(char)* path,
	uint mode,
	git_transfer_progress_callback progress_cb,
	void *progress_cb_payload);
const(git_oid)* git_packbuilder_hash(git_packbuilder *pb);

alias git_packbuilder_foreach_cb = int function(void *buf, size_t size, void *payload);

int git_packbuilder_foreach(git_packbuilder *pb, git_packbuilder_foreach_cb cb, void *payload);
uint32_t git_packbuilder_object_count(git_packbuilder *pb);
uint32_t git_packbuilder_written(git_packbuilder *pb);

alias git_packbuilder_progress = int function(
	int stage,
	uint current,
	uint total,
	void *payload);

int git_packbuilder_set_callbacks(
	git_packbuilder *pb,
	git_packbuilder_progress progress_cb,
	void *progress_cb_payload);
void git_packbuilder_free(git_packbuilder *pb);
