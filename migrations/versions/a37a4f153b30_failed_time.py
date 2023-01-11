"""failed time

Revision ID: a37a4f153b30
Revises: a58fd2921d46
Create Date: 2022-12-28 18:51:30.176869

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a37a4f153b30'
down_revision = 'a58fd2921d46'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_time_test', schema=None) as batch_op:
        batch_op.add_column(sa.Column('failed_at', sa.String(length=20), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_time_test', schema=None) as batch_op:
        batch_op.drop_column('failed_at')

    # ### end Alembic commands ###
