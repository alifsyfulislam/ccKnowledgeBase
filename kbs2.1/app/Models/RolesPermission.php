<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
<<<<<<< HEAD
use Illuminate\Database\Eloquent\Model;
=======
//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;
>>>>>>> 87a329c1058e3f6a35fe686d57319004d7190965

class RolesPermission extends Model
{
    protected $collection = 'roles_permissions';
//    protected $primaryKey = 'role_id';
    use HasFactory;
}
