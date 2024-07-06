<?php 
namespace App\Validation;
use Config\Database;

class EyRules
{
   /**
     * 根据数据表2个字段来确认唯一性
     *
     * Example:
     *    is_unique2[sys_dict.code,tname,'news']
     */
    public function is_unique2(?string $str, string $field, array $data): bool
    {
        [$field, $field2, $value2] = array_pad(explode(',', $field), 3, null);

        sscanf($field, '%[^.].%[^.]', $table, $field);

        $row = Database::connect($data['DBGroup'] ?? null)
            ->table($table)
            ->select('1')
            ->where($field, $str)
            ->limit(1);

        if (! empty($field2) && ! empty($value2) && ! preg_match('/^\{(\w+)\}$/', $value2)) {
            $row = $row->where("{$field2}", $value2);
        }

        return $row->get()->getRow() === null;
    }
}