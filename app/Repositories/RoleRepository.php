<?php


namespace App\Repositories;


use App\Models\Role;

class RoleRepository implements RepositoryInterface
{
    /**
     * @return mixed
     */
    public function all()
    {
        return Role::orderBy('id', 'DESC')->get();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {

        return Role::with(['permissions' => function($q) {$q->select('id', 'name');}])->findOrFail($id);

    }

    /**
     * @param array $data
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model
     */
    public function create(array $data)
    {
        return Role::create($data);
    }

    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return Role::find($id)->update($data);
    }

    /**
     * @param $id
     */
    public function delete($id)
    {
        return Role::find($id)->delete();
    }


    public function getWithPagination()
    {
        return Role::orderBy('id', 'DESC')->paginate(10);
    }
}
