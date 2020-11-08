<?php


namespace App\Repositories;


use App\Models\Permission;

class PermissionRepository implements RepositoryInterface
{
    /**
     * @return mixed
     */
    public function all()
    {
        return Permission::orderBy('id', 'DESC')->get();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {

        return Permission::findOrFail($id);

    }

    /**
     * @param array $data
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model
     */
    public function create(array $data)
    {
        return Permission::create($data);
    }

    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return Permission::find($id)->update($data);
    }

    /**
     * @param $id
     */
    public function delete($id)
    {
        return Permission::find($id)->delete();
    }

    public function getWithPagination()
    {
        return Permission::orderBy('id', 'DESC')->paginate(10);
    }
}
