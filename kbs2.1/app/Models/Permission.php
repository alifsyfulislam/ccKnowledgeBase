<?php

namespace App\Models;


<<<<<<< HEAD
use Illuminate\Database\Eloquent\Model;
=======
//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;
>>>>>>> 87a329c1058e3f6a35fe686d57319004d7190965

class Permission extends Model
{
    protected $collection = 'permissions';
    protected $primaryKey = 'id';

    /**
     * @var string[]
     */
    protected $fillable = ['name', 'slug'];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function roles() 
    {

        return $this->belongsToMany(Role::class,'roles_permissions');
            
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function users() 
    {

        return $this->belongsToMany(User::class,'users_permissions');
            
    }

    /**
     * @param $date
     * @return string
     */
    public function getCreatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }

    /**
     * @param $date
     * @return string
     */
    public function getUpdatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }
}
